#include "input.h"

#include <algorithm>
#include <iostream>

void InputData::setStart(int value, const SolverConfig& config) {
    if (!config.isValueInRange(value)) {
        error("Start position out of range");
    }
    start = value;
}

void InputData::setTarget(int value, const SolverConfig& config) {
    if (!config.isValueInRange(value)) {
        error("Target position out of range");
    }
    target = value;
}

void InputData::setFinalMovesExecutionOrder(const std::vector<int>& moves,
                                            const SolverConfig& config) {
    if (moves.empty() || moves.size() > 3) {
        error("Invalid number of final moves. Allowed: 1-3 moves");
    }

    for (int move : moves) {
        if (!config.isAllowedMove(move)) {
            error("Invalid final move: ", std::to_string(move));
        }
    }

    finalMoves = moves;
}

void InputData::setFinalMovesLastToFirst(const std::vector<int>& moves,
                                         const SolverConfig& config) {
    std::vector<int> executionOrder = moves;
    std::reverse(executionOrder.begin(), executionOrder.end());
    setFinalMovesExecutionOrder(executionOrder, config);
}

void InputData::setFinalMoves(const std::vector<int>& moves,
                              const SolverConfig& config) {
    setFinalMovesExecutionOrder(moves, config);
}

void InputData::printConsoleHelp() {
    std::cout
        << "Enter start, target, and final moves.\n"
        << "Final moves are entered in execution order: third-last, second-last, last.\n"
        << "Example: 0 113 13 7 2\n"
        << "start=0, target=113, final end moves: +13, +7, +2\n"
        << "Allowed moves: +16 +13 +7 +2 -3 -6 -9 -15\n\n";
}
