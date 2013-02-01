#include <ruby.h>

RUBY_GLOBAL_SETUP

int main(int argc, char *argv[])
{
  int status;
  {
    RUBY_INIT_STACK;
    ruby_init();
    ruby_script(argv[0]);
    rb_protect((VALUE (*)(VALUE))rb_require, (VALUE)"./embedded_ruby.rb", &status);
    // ruby_cleanup(0);
    ruby_finalize();
  };
  return status;
}

