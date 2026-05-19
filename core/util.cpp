#include "util.h"

[[noreturn]] void error(const std::string& message) {
    throw std::runtime_error(message);
}

[[noreturn]] void error(const std::string& messagePart1, const std::string& messagePart2) {
    throw std::runtime_error(messagePart1 + messagePart2);
}
