set(component_b_target component_b_app)

add_executable(
    ${component_b_target}
    _core/_src/main.cpp
)

target_link_libraries(
    ${component_b_target}
    PRIVATE
        shared_core
)

target_compile_definitions(
    ${component_b_target}
    PRIVATE
        MY_MACRO
        COMPONENT_NAME=\"component_b\"
)

if(ENABLE_COMPONENT_TESTS)
    add_executable(component_b_tests _test/test.cpp)
    target_link_libraries(component_b_tests PRIVATE shared_core GTest::gtest_main)
    target_compile_definitions(
        component_b_tests
        PRIVATE
            COMPONENT_NAME=\"component_b\"
    )

    include(GoogleTest)
    gtest_discover_tests(component_b_tests)
endif()
