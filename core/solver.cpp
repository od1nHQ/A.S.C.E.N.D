#include "solver.h"

#include <algorithm>
#include <queue>

int SolveResult::stepsCount() const {
    return static_cast<int>(path.size());
}

AscendSolver::AscendSolver(SolverConfig config)
    : config(std::move(config)) {}

int AscendSolver::calculateAdjustedTarget(const InputData& input) const {
    int adjustedTarget = input.target;

    for (int move : input.finalMoves) {
        adjustedTarget -= move;
    }

    return adjustedTarget;
}

bool AscendSolver::validateInput(const InputData& input, SolveResult& result) const {
    if (!config.isValueInRange(input.start)) {
        result.message = "Start position is out of range.";
        return false;
    }

    if (!config.isValueInRange(input.target)) {
        result.message = "Target position is out of range.";
        return false;
    }

    if (input.finalMoves.empty() || input.finalMoves.size() > 3) {
        result.message = "Final moves count must be from 1 to 3.";
        return false;
    }

    for (int move : input.finalMoves) {
        if (!config.isAllowedMove(move)) {
            result.message = "Final moves contain an unsupported move.";
            return false;
        }
    }

    int adjustedTarget = calculateAdjustedTarget(input);
    if (!config.isValueInRange(adjustedTarget)) {
        result.adjustedTarget = adjustedTarget;
        result.message = "Adjusted target is out of allowed range.";
        return false;
    }

    return true;
}

std::vector<int> AscendSolver::reconstructPath(
    int start,
    int target,
    const std::vector<int>& parent,
    const std::vector<int>& parentMove) const {

    std::vector<int> path;

    int current = target;
    while (current != start) {
        int move = parentMove[current];
        path.push_back(move);
        current = parent[current];
    }

    std::reverse(path.begin(), path.end());
    return path;
}

SolveResult AscendSolver::solve(const InputData& input) const {
    SolveResult result;
    result.adjustedTarget = calculateAdjustedTarget(input);

    if (!validateInput(input, result)) {
        result.found = false;
        return result;
    }

    const int rangeSize = config.maxValue + 1;
    std::vector<bool> visited(rangeSize, false);
    std::vector<int> parent(rangeSize, -1);
    std::vector<int> parentMove(rangeSize, 0);
    std::queue<int> queue;

    visited[input.start] = true;
    queue.push(input.start);

    bool reached = (input.start == result.adjustedTarget);

    while (!queue.empty() && !reached) {
        int current = queue.front();
        queue.pop();

        for (int move : config.moves) {
            int next = current + move;

            if (!config.isValueInRange(next)) {
                continue;
            }

            if (visited[next]) {
                continue;
            }

            visited[next] = true;
            parent[next] = current;
            parentMove[next] = move;

            if (next == result.adjustedTarget) {
                reached = true;
                break;
            }

            queue.push(next);
        }
    }

    if (!reached) {
        result.found = false;
        result.message = "No path found.";
        return result;
    }

    result.path = reconstructPath(input.start, result.adjustedTarget, parent, parentMove);

    // finalMoves are already stored in execution order: third-last -> ... -> last.
    result.path.insert(result.path.end(), input.finalMoves.begin(), input.finalMoves.end());

    result.found = true;
    result.message = "Path found.";
    return result;
}
