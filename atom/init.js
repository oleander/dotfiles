// /* @flow */
//
// /* eslint no-sync: "off" */
//
// import {compile} from "es6-arrow-function";
// import {exec} from "child_process";
// import path from "path";
// import fs from "fs-extra";
// import Promise from "bluebird";
// import ConfigFile from "eslint/lib/config/config-file";
// import Config from "eslint/lib/config";
//
// const mods = path.join(__dirname, "/node_modules");
// const jscodeshift = path.join(mods, ".bin", "jscodeshift");
// const config = "/Users/oleander/Documents/Projekt/dotfiles/node/eslintrc.json";
//
// declare var atom: any;
//
// function showWarn(message: string, detail: ?string) {
//   return wait(atom.notifications.addWarning(message, {detail, dismissable: true}));
// }
//
// function transform(type: string, file: string) {
//   const script = path.join(mods, "5to6-codemod/transforms", [type, ".js"].join(""));
//   return command([jscodeshift, "-t", script, file].join(" "));
// }
//
// function showSuccess(message: string, detail: ?string) {
//   return wait(atom.notifications.addSuccess(message, {detail, dismissable: true}));
// }
//
// function showInfo(message: string, detail: ?string) {
//   return wait(atom.notifications.addInfo(message, {detail, dismissable: true}));
// }
//
// function showError(message: string, error: Error) {
//   return wait(atom.notifications.addError(message, {
//     detail: error.message,
//     stack: error.stack,
//     dismissable: true
//   }));
// }
//
// function wait(item) {
//   setTimeout(function() {
//     item.dismiss();
//   }, 10000);
// }
//
// function getPath() : ?string {
//   return atom.project.getPaths()[0];
// }
//
// function command(cmd: string) : Promise<void> {
//   const cwd = getPath();
//   if (!cwd) return showWarn("No editor found");
//   showInfo(`Running '${cmd}' from: '${cwd}', hold on`);
//   return new Promise(function(resolve, reject) {
//     exec(cmd, {cwd}, function(error, stdout, stderr) {
//       if (error) reject(error);
//       else resolve([stdout.toString(), stderr.toString()].join("\n"));
//     });
//   }).catch(function(error) {
//     showError("Could not run command", error);
//   }).then(function(result) {
//     showSuccess("Succesfully ran command", result);
//   });
// }
//
// function findLocal(configs: string[], current: string) : ?string {
//   return configs.find(function(config) {
//     return path.relative(path.dirname(config), current) === "";
//   });
// }
//
// atom.commands.add("atom-workspace", "custom:flow-stop", function() {
//   command("flow stop");
// });
//
// atom.commands.add("atom-workspace", "custom:flow-restart", function() {
//   command("flow stop").then(function() {
//     return command("flow start");
//   });
// });
//
// atom.commands.add("atom-workspace", "custom:flow-start", function() {
//   command("flow start");
// });
//
// atom.commands.add("atom-workspace", "custom:flow-tag", function() {
//   const editor = atom.workspace.getActiveTextEditor();
//   if (!editor) return showWarn("No editor found");
//   const buffer = atom.workspace.getActiveTextEditor().getBuffer();
//   if (buffer.getText().includes("@flow")) {
//     return showWarn("Page already includes a @flow tag");
//   }
//
//   const lineEnding = buffer.lineEndingForRow(0) || "\n";
//   buffer.insert([0, 0], "/* @flow */" + lineEnding + lineEnding);
//   showSuccess("@flow tag has been inserted");
// });
//
// atom.commands.add("atom-workspace", "custom:npm-install", function() {
//   command("npm install");
// });
//
// atom.commands.add("atom-workspace", "custom:flow-init", function() {
//   command("flow init");
// });
//
// atom.commands.add("atom-workspace", "custom:flow-typed", function() {
//   command("flow-typed install");
// });
//
// atom.commands.add("atom-workspace", "custom:close-notification", function() {
//   atom.notifications.getNotifications().forEach(function(notification) {
//     notification.dismiss();
//   });
// });
//
// atom.commands.add("atom-workspace", "custom:convert-from-es6-arrow", function() {
//   const editor = atom.workspace.getActiveTextEditor();
//   if (!editor) return showWarn("No editor found");
//   const code = editor.getText();
//   const position = editor.getCursorBufferPosition();
//   editor.setText(compile(code).code);
//   editor.setCursorBufferPosition(position);
//   showSuccess("Done transpiling arrow functions!");
// });
//
// atom.commands.add("atom-workspace", "custom:convert-to-es6-import", function() {
//   const editor = atom.workspace.getActiveTextEditor();
//   if (!editor) return showWarn("No editor found");
//   const position = editor.getCursorBufferPosition();
//   transform("cjs", editor.getPath()).then(function() {
//     editor.setCursorBufferPosition(position);
//   });
// });
//
// atom.commands.add("atom-workspace", "custom:convert-to-es6-exports", function() {
//   const editor = atom.workspace.getActiveTextEditor();
//   if (!editor) return showWarn("No editor found");
//   const position = editor.getCursorBufferPosition();
//   transform("exports", editor.getPath()).then(function() {
//     editor.setCursorBufferPosition(position);
//   });
// });
//
// atom.commands.add("atom-workspace", "custom:copy-my-eslint-config", function() {
//   const dir = getPath();
//   if (!dir) return showWarn("No path found");
//   fs.copySync(config, path.join(dir, ".eslintrc.json"));
//   showSuccess("Done copying .eslintrc.json");
// });
//
// atom.commands.add("atom-workspace", "custom:install-missing-eslint-dependencies", function() {
//   const dir = getPath();
//   if (!dir) return showWarn("No path found");
//   const config = new Config({});
//   const configs = config.findLocalConfigFiles(dir);
//   const localConfig = findLocal(configs, dir);
//
//   if (!localConfig) {
//     return showWarn(`No local configs: ${configs.join(", ")}, dir: ${dir}`);
//   }
//
//   const toRelative = path.relative(dir, localConfig);
//   showSuccess(`Using config: ${toRelative}`);
//
//   fs.readFile(localConfig, function(err, output) {
//     if (err) return showError(`Could not load: ${toRelative}`, err);
//     const json = JSON.parse(output.toString());
//     const packages = [];
//     (json.extends || []).forEach(function(name) {
//       packages.push(ConfigFile.normalizePackageName(name, "eslint-config"));
//     });
//
//     (json.plugins || []).forEach(function(name) {
//       packages.push(ConfigFile.normalizePackageName(name, "eslint-plugin"));
//     });
//
//     if (!packages.length) {
//       return showSuccess(`No packages found in ${toRelative}`, output.toString());
//     }
//
//     showSuccess(`Found ${packages.length} packages, installing`, packages.join(", "));
//     command(`npm install ${packages.join(" ")} --save-dev`);
//   });
// });
//
// type Pane = Object;
//
// atom.commands.add("body", "custom:cycle-right", function() {
//   if (hasNoPanes()) return;
//   if (isLastTab()) return activateNextPanel(0);
//   activateNextTab();
// });
//
// atom.commands.add("body", "custom:cycle-left", function() {
//   if (hasNoPanes()) return;
//   if (isFirstTab()) return activatePrevPanel(-1);
//   activatePrevTab();
// });
//
// function mod(n: number, m: number) : number {
//   return ((n % m) + m) % m;
// }
//
// function hasNoPanes() : boolean {
//   return getPanes().length === 0;
// }
//
// function getPanes() : Pane[] {
//   return atom.workspace.getPanes();
// }
//
// function getActivePane() : Pane {
//   return atom.workspace.getActivePane();
// }
//
// function getTabIndex() : number {
//   return getActivePane().getActiveItemIndex();
// }
//
// function activateNextTab() {
//   getActivePane().activateNextItem();
// }
//
// function activatePrevTab() {
//   getActivePane().activatePreviousItem();
// }
//
// function getNumberOfTabs() : number {
//   return getActivePane().getItems().length;
// }
//
// function noTabs() : boolean {
//   return getNumberOfTabs() === 0;
// }
//
// function isLastTab() : boolean {
//   if (noTabs()) return true;
//   return getNumberOfTabs() === getTabIndex() + 1;
// }
//
// function isFirstTab() : boolean {
//   if (noTabs()) return true;
//   return getTabIndex() === 0;
// }
//
// function getCurrentPaneIndex() : number {
//   const panes = getPanes();
//   const activePane = getActivePane();
//   if (!panes.length) throw new Error("No panes found");
//   for (let i = 0; i < panes.length; i++) {
//     if (panes[i] === activePane) return i;
//   }
//
//   throw new Error("Could not find active panel");
// }
//
// function getNextPane() : Pane {
//   const index = getCurrentPaneIndex();
//   const panes = getPanes();
//   return panes[mod(index + 1, panes.length)];
// }
//
// function activateNextPanel(tabIndex: number) : void {
//   const nextPane = getNextPane();
//   nextPane.activate();
//   nextPane.activateItemAtIndex(tabIndex);
// }
//
// function activatePrevPanel(tabIndex: number) : void {
//   const prevPane = getPrevPane();
//   const noItems = prevPane.getItems().length;
//   prevPane.activate();
//   prevPane.activateItemAtIndex(mod(tabIndex, noItems));
// }
//
// function getPrevPane() : Pane {
//   const index = getCurrentPaneIndex();
//   const panes = getPanes();
//   return panes[mod(index - 1, panes.length)];
// }
//
// // -1 == left, 1 == right
// // function move(prefix: number) : void {
// //   const panes = atom.workspace.getPanes();
// //   function noPanes() : boolean {
// //     return panes.length === 0;
// //   }
// //
// //   /*
// //   - 0 panes
// //     - Action: do nothing
// //   */
// //
// //   if (noPanes()) return;
// //
// //   function onePane() : boolean {
// //     return panes.length === 1;
// //   }
// //
// //   const activePane = atom.workspace.getActivePane();
// //   const noTabs = activePane.getItems().length;
// //   const index = activePane.getActiveItemIndex();
// //
// //   function isAtEnd() : boolean {
// //     if (prefix === 1) return noTabs === index + 1;
// //     else return noTabs === 0;
// //   }
// //
// //   function getCurrentPaneIndex() : index {
// //     if (!panes.length) throw new Error("No panes found");
// //     for (let i = 0; i < panes.length; i++) {
// //       if (panes[i] === activePane) return i;
// //     }
// //
// //     throw new Error("Could not find active panel");
// //   }
// //
// //   function getNextPane() : Pane {
// //     if (panes.length === 0) throw new Error("No panes");
// //     return panes[mod(getCurrentPaneIndex() + 1 * prefix, panes.length)];
// //   }
// //
// //   function setNextTab() : void {
// //     if (noTabs === 0) throw new Error("No tabs to pick from");
// //     activePane.activateItemAtIndex(mod(index + 1 * prefix, noTabs));
// //   }
// //
// //   /*
// //   - 1 pane
// //     - end of tab: move to tab: 0
// //     - not end of tab: move to tab: n + 1
// //   */
// //
// //   if (onePane()) {
// //     return setNextTab();
// //   }
// //
// //   if (isAtEnd()) {
// //     return getNextPane().activate();
// //   }
// //
// //   setNextTab();
// // }
