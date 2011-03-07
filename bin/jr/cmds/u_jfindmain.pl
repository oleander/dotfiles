sub u_jfindmain() {
  return u_findmain(".java",
         "`javac filename_of_main_class; java name_of_main_class'");
}

