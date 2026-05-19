#pragma once

#include <stdexcept>
#include <string>

const int MIN_VALUE = 0;
const int MAX_VALUE = 150;

[[noreturn]] void error(const std::string& message);
[[noreturn]] void error(const std::string& messagePart1, const std::string& messagePart2);
