#include "config.h"

#include <algorithm>

bool SolverConfig::isValueInRange(int value) const {
    return value >= minValue && value <= maxValue;
}

bool SolverConfig::isAllowedMove(int move) const {
    return std::find(moves.begin(), moves.end(), move) != moves.end();
}

SolverConfig makeDefaultSolverConfig() {
    SolverConfig config;
    config.minValue = MIN_VALUE;
    config.maxValue = MAX_VALUE;
    config.moves = { 16, 13, 7, 2, -3, -6, -9, -15 };
    return config;
}
