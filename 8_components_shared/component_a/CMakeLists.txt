set(component_a_target component_a_app)

add_executable(
    ${component_a_target}
    _core/_src/main.cpp
)

target_link_libraries(
    ${component_a_target}
    PRIVATE
        shared_core
)

target_compile_definitions(
    ${component_a_target}
    PRIVATE
        MY_MACRO
        COMPONENT_NAME=\"component_a\"
)

if(ENABLE_COMPONENT_TESTS)
    add_executable(component_a_tests _test/test.cpp)
    target_link_libraries(component_a_tests PRIVATE shared_core GTest::gtest_main)
    target_compile_definitions(
        component_a_tests
        PRIVATE
            COMPONENT_NAME=\"component_a\"
    )

    include(GoogleTest)
    gtest_discover_tests(component_a_tests)
endif()
