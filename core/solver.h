#pragma once

#include <string>
#include <vector>

#include "config.h"
#include "input.h"

struct SolveResult {
    bool found{ false };
    std::vector<int> path;
    std::string message;
    int adjustedTarget{ 0 };

    int stepsCount() const;
};

class AscendSolver {
public:
    explicit AscendSolver(SolverConfig config = makeDefaultSolverConfig());

    // GUI-friendly API: pass pure data, receive pure result.
    // No cin, cout, or process exit inside.
    SolveResult solve(const InputData& input) const;

private:
    SolverConfig config;

    bool validateInput(const InputData& input, SolveResult& result) const;
    int calculateAdjustedTarget(const InputData& input) const;
    std::vector<int> reconstructPath(int start,
                                     int target,
                                     const std::vector<int>& parent,
                                     const std::vector<int>& parentMove) const;
};
