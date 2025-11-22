execute_process(
    COMMAND git submodule update --init --recursive
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    RESULT_VARIABLE GIT_SUBMOD_RESULT
)

if(GIT_SUBMOD_RESULT EQUAL 0)
    message(STATUS "Git submodule updated successfully")
else()
    message(FATAL_ERROR "Failed to update git submodule")
endif()
