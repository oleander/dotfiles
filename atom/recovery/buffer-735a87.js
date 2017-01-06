/* @flow */
/* eslint no-unused-vars: "off" */

import Linter from "./worker/main";
import {CompositeDisposable, Emitter} from "atom";
import {autobind} from "core-decorators";
import util from "util";
import debug from "./debug";
let counter = 0;

@autobind
export default class MyBuffer {
  lastChangeCount: number = -1;
  emitter: Emitter = new Emitter();
  subs: CompositeDisposable = new CompositeDisposable();
  isDestroyed: boolean = false;
  isActive: boolean = true;
  reason: ?string = "startup"
  buffer: TextBuffer;
  changeCount: number;
  fixOnSave: boolean;
  linter: Linter;
  counter: number = counter++;
  log: typeof debug;

  constructor(buffer: TextBuffer, linter: Linter, fixOnSave: boolean) {
    this.log = debug.init("b:" + String(this.counter));
    this.fixOnSave = fixOnSave;
    this.linter = linter;
    this.buffer = buffer;
    this.lastChangeCount = this.buffer.changeCount;

    this.subs.add(this.emitter);
    this.subs.add(this.linter);

    this.linter.onDidLint(this._onDidLint);
    this.buffer.onDidDestroy(this.dispose);

    this.subs.add(this.buffer.onDidChangeText(this._onDidChangeText));

    /* Error handling */
    this.linter.onDidFailFix(function({error, file}) {
      if (!this._is(file)) return;
      this.log.error("Could not fix %p due to %e", file, error);
      this._emit("buffer:error", {message: "Failed on fix", error});
    }.bind(this));
    this.linter.onDidFailLinting(function({error, code, file}) {
      if (!this._is(file)) return;
      this.log.error("Could not lint %p due to %e", file, error);
      this._emit("buffer:error", {message: "Failed linting", error});
    }.bind(this));

    this._on("internal:is-active", this._onDidBecomeActive);
    this._on("internal:is-inactive", this._onDidBecomeInactive);

    this.linter.onDidIgnoreFile(function(...args) {
      this.log.tag("did-ignore-file").warn("Is ignored with args %o", args);
    }.bind(this));

    this.linter.onDidReloadDueToChangedIgnoreFile(function(...args) {
      this.log.tag("did-reload-due-to-changed-ignore-file").info("Passed args %o", args);
    }.bind(this));

    this.linter.onDidReloadDueToChangedPackageFile(function(...args) {
      this.log.tag("on-did-reload-due-to-changed-package-file").info("Passed args %o", args);
    }.bind(this));

    this.linter.onDidReloadConfig(function(...args) {
      this.log.tag("on-did-reload-config", "Did reload config with args %o", args);
    }.bind(this));

    // TODO: Listen for changed path
    this.linter.onDidIgnoreFile(this._onDidIgnoreFile);
    this.linter.onDidReloadDueToChangedIgnoreFile(this.lint);
    this.linter.onDidReloadDueToChangedPackageFile(this.lint);
    this.linter.onDidReloadConfig(this.lint);
    this.onDidBecomeActive(this.lint);
    this.onDidBecomeActive(function() {
      this.reason = null;
    }.bind(this));
    this.onDidBecomeInactive(function() {
      this._emit("buffer:invalidate");
    }.bind(this));
    this.onDidBecomeInactive(function(reason) {
      this.reason = reason;
    }.bind(this));
    this.onError(function(error) {
      this.log.error("On error %e", error);
    }.bind(this));
  }

  _is(file: string) : boolean {
    return this._getPath() === file;
  }

  _onDidIgnoreFile({code, file}) {
    if (!this._is(file)) return;
    this._emit("internal:is-inactive", "Linter marked file as ignored");
  }

  _onDidBecomeInactive(reason: string) {
    if (!this.isActive) return;
    this.isActive = false;
    this._emit("buffer:is-inactive", reason);
  }

  _onDidChangeText({changes}) : void {
    const log = this.log.group("change-text", "State: %s", this.isActive ? "active" : "not active");

    if (!this.isActive) {
      return log.debug("Abort, is inactive");
    }

    if (this.changeCount === this.buffer.changeCount) {
      return log.debug("Buffer has not changed its 'changeCount' from %s", this.changeCount);
    }

    if (!changes.length) {
      return log.debug("No changed has been made, abort");
    }

    if (this.fixOnSave) {
      log.info("Running 'fix' on %p", this._getPath());
      this.fix(this._getPath());
    }

    this.lint();
  }

  _on(event: string, callback: Function) {
    this.subs.add(this.emitter.on(event, callback));
  }

  _onDidBecomeActive(reason: string) {
    if (this.isActive) return;
    this.isActive = true;
    this._emit("buffer:is-active", reason);
  }

  _getCode() : string {
    return this.buffer.getText();
  }

  activate() {
    this.isActive = true;
  }

  deactivate() {
    this.isActive = false;
  }

  _getPath() : string {
    return this.buffer.getPath();
  }

  _emit(event: string, ...args: any[]) : any {
    this.log.info("Emitting event %s from buffer path %p", event, this._getPath());
    return this.emitter.emit(event, ...args);
  }

  _onDidLint({report: messages, code, file}: Object) {
    const log = this.log.init("did-lint");
    if (!this._is(file)) return log.debug("No match %p did not match %p", this._getPath(), file);
    if (this.isDestroyed) return log.debug("Is already destroyed");
    if (!this.isActive) return log.debug("Is not active");
    if (this.buffer.changeCount !== this.changeCount) {
      return log.info("Count changed %s to %s, abort", this.changeCount, this.buffer.changeCount);
    }

    messages.forEach(function(message, index) {
      log.info(
        "Lint message (%s/%s): rule %s, fatal: %s, message: %s, line: %s, col: %s",
        index + 1,
        messages.length,
        message.ruleId,
        message.message,
        message.line,
        message.column
      );
    });

    if (!messages.length) {
      log.debug("No messages, invalidating the old change");
      this._emit("buffer:invalidate");
    } else {
      log.debug("Got %s linter messages for %p", messages.length, file);
      this._emit("buffer:lint", messages);
    }
  }

  toString() : string {
    return util.inspect({
      reason: this.reason,
      changeCount: this.changeCount,
      isActive: this.isActive,
      isDestroyed: this.isDestroyed,
      lastChangeCount: this.changeCount,
      path: this._getPath(),
      fixOnSave: this.fixOnSave
    }, {depth: null});
  }

  setFixOnSave(fixOnSave: boolean) {
    this.fixOnSave = fixOnSave;
  }

  onDidBecomeInactive(callback: (reason: string) => void) {
    this._on("buffer:is-inactive", callback);
  }

  onDidBecomeActive(callback: (reason: string) => void) {
    this._on("buffer:is-active", callback);
  }

  lint() {
    const log = this.log.group("lint", "Linting");
    if (!this.isActive) return log.warn("Not active");
    if (this.isDestroyed) return log.warn("Is destroyed");

    if (this.buffer.isEmpty()) {
      log.warn("Is empty, sending buffer:invalidate");
      return this._emit("buffer:invalidate");
    }

    log.info("Change this.changeCount from %s to %s", this.changeCount, this.buffer.changeCount);
    this.changeCount = this.buffer.changeCount;
    log.info("Linting buffer from path %p", this._getPath());
    this.linter.lint(this._getCode(), this._getPath());
  }

  onDidInvalidate(callback: () => void) {
    this._on("buffer:invalidate", callback);
  }

  dispose() {
    if (this.isDestroyed) return;
    this.subs.dispose();
    this.isDestroyed = true;
    this._emit("buffer:did-destroy");
  }

  fix() {
    this.log.info("Fixing %p", this._getPath());
    this.linter.fix(this._getPath());
  }

  onDidDestroy(callback: () => void) {
    this._on("buffer:did-destroy", callback);
  }

  onDidFix(callback: () => void) {
    this._on("buffer:fix", callback);
  }

  onDidLint(callback: (report: Object) => void) {
    this._on("buffer:lint", callback);
  }

  onError(callback: (error: string) => void) {
    this._on("buffer:error", callback);
  }

  getPath() : string {
    return this.buffer.getPath();
  }
}