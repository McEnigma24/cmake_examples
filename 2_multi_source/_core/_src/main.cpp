#include <iostream>

#include "util.h"       // local

int main()
{
    std::cout << "Multi-source example says: " << format_message("Hello") << std::endl << std::endl << std::endl;

    line("My Macro");

    int a = 10;
    int b = 11;

    var(a);
    var(b);

    return 0;
}
