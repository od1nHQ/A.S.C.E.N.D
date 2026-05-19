#pragma once

#include <vector>

#include "util.h"

// Configuration of the forging solver.
// It is intentionally simple: moves are stored as numbers, because the game UI
// shows the numeric effect of each action.
struct SolverConfig {
    int minValue{ MIN_VALUE };
    int maxValue{ MAX_VALUE };
    std::vector<int> moves;

    bool isValueInRange(int value) const;
    bool isAllowedMove(int move) const;
};

SolverConfig makeDefaultSolverConfig();
