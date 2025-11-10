# adding all internal libraries
add_subdirectory(_libs/math)
set(ALL_LIBRARIES ${ALL_LIBRARIES} internal_lib_math)



# 1 - json #
include(FetchContent)
FetchContent_Declare(
    json
    GIT_REPOSITORY https://github.com/nlohmann/json.git
    GIT_TAG        master
)
# FetchContent_Populate(json)      # pobiera
FetchContent_MakeAvailable(json)   # pobiera i buduje ==> Populate + add_subdirectory

# list(APPEND ALL_LIBRARIES nlohmann_json::nlohmann_json)
set(ALL_LIBRARIES ${ALL_LIBRARIES} nlohmann_json::nlohmann_json)
include_directories(${json_SOURCE_DIR}/include/nlohmann)

add_executable(${CONST_TARGET_NAME} ${SOURCES})
target_link_libraries(${CONST_TARGET_NAME} PRIVATE ${ALL_LIBRARIES})
target_compile_definitions(${CONST_TARGET_NAME} PRIVATE MY_MACRO) # dodajemy własne makro