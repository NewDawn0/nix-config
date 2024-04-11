#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

void up(int lim);
void init();


int main(int argc, char *argv[]) {
    int lim= 1;
    if (argc > 1) {
      if (strcmp(argv[1], "init") == 0) {
        init();
        return 0;
      }
      lim= atoi(argv[1]);
    }
    up(lim);
    return 0;
}

void init() {
  const char* init_func[] = {
    "function up() {",
    " eval $(up-core \"$@\")",
    "}",
  };
  printf("Add this to your shell rc\n```\n");
  for (int i = 0; i < sizeof(init_func) / sizeof(init_func[0]); i++) {
        printf("%s\n", init_func[i]);
  }
  printf("```\n");
}

void up(int lim) {
  if (lim<=0) lim= 1;
  printf("cd ");
  for (int i=0; i< lim; i++) {
    printf("../");
  }
  printf("\n");
}
