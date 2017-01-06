/* @flow */

// TODO: Copy 'showMessage' messages from original repo
// TODO: [?] On 'fix', store the user's location and then jump back to if if the file
// 'flashes' (which is dones when the file is overwritten)

import {DiagnosticsProviderBase} from "nuclide-diagnostics-provider-base";
import {CompositeDisposable} from "atom";
import nuclide from "./reports/nuclide";
import {pre} from "./reports/helper";
import Project from "./load";
import debug from "./debug";

const subs = new CompositeDisposable();
const provider = new DiagnosticsProviderBase({
  enableForAllGrammars: true,
  shouldRunOnTheFly: true
});

debug.info("Starting application");

function addPaths(paths) {
  debug.warn("%s as paths added to project", paths);
  paths.forEach(function(path) {
    const project = new Project(path);
    project.onDidFailLinting(function(...args) {
      debug.error("Did fail linting with args %o", args);
    });

    project.onDidInvalidate(function(editor) {
      const path = editor.getBuffer().getPath();
      debug.info("Invalidate editor with path %p", path);
      provider.publishMessageInvalidation({
        scope: "file",
        filePaths: [path]
      });
    });

    project.onDidFailToStart(function({message, error}) {
      debug.error("Did fail to start", {message, error});
    });

    project.onDidStart(function(...args) {
      debug.warn("Did start with args %o", args);
    });

    project.onError(function(error) {
      debug.error("Received error %e", error);
    });

    project.onDidLint(function({messages, editor}) {
      const path = editor.getBuffer().getPath();
      debug.info("Did receive %s messages for editor %p", messages.length, path);
      const messages2 = pre(messages, editor, true);
      provider.publishMessageUpdate(nuclide(messages2, path));
    });

    subs.add(project);
  });
}

export function activate() {
  debug.info("Project is active");
  subs.add(atom.project.onDidChangePaths(addPaths));
  addPaths(atom.project.getPaths());
}

export function deactivate() {
  debug.warn("Deactivated project");
  subs.dispose();
}

export function provideDiagnostics() {
  debug.info("provideDiagnostics called");
  return {
    onMessageUpdate(callback: Function) {
      return provider.onMessageUpdate(callback);
    },
    onMessageInvalidation(callback: Function) {
      return provider.onMessageInvalidation(callback);
    }
  };
}

// TODO: Re-add this
// export function consumeLinter(reg: IndieRegistry) {
//   const newMessages = linter.newMessages;
//   linter: Indie = reg.register(linterConfig);
//   add(linter);
//   const editor = getCurrentEditor();
// }
