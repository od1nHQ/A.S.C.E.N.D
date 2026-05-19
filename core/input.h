#pragma once

#include <vector>

#include "config.h"
#include "util.h"

// InputData contains only raw data for the solver.
// No cin/cout should be required to use this class from GUI.
class InputData {
public:
    int start{ 0 };
    int target{ 0 };

    // Stored in real execution order:
    // third-last -> second-last -> last.
    // Example: if the game requires +7, -2, +6 at the end,
    // finalMoves must be { 7, -2, 6 }.
    std::vector<int> finalMoves;

    void setStart(int value, const SolverConfig& config = makeDefaultSolverConfig());
    void setTarget(int value, const SolverConfig& config = makeDefaultSolverConfig());

    // Preferred for GUI: buttons can fill slots left-to-right.
    void setFinalMovesExecutionOrder(const std::vector<int>& moves,
                                     const SolverConfig& config = makeDefaultSolverConfig());

    // Compatibility helper for the old console style:
    // user enters last -> second-last -> third-last.
    // Example input: 6 -2 7 becomes { 7, -2, 6 } internally.
    void setFinalMovesLastToFirst(const std::vector<int>& moves,
                                  const SolverConfig& config = makeDefaultSolverConfig());

    // Backward-compatible alias. It now means execution order.
    void setFinalMoves(const std::vector<int>& moves,
                       const SolverConfig& config = makeDefaultSolverConfig());

    static void printConsoleHelp();
};
