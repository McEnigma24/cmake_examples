#include <iostream>

#include "util.h"       // local

int main()
{
    std::cout << "Multi-source example says: " << format_message("Hello") << std::endl << std::endl << std::endl;

    line("My Macro");

    return 0;
}
