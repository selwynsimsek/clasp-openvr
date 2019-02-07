#include <clasp/clasp.h>

void startup()
{
  using namespace clbind;
  package("clasp-openvr")[
                    // binding code comes here
                    ];
}

CLASP_REGISTER_STARTUP(startup);
