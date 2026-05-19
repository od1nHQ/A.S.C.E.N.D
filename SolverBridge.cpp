#include "SolverBridge.h"

#include <exception>
#include <QString>

SolverBridge::SolverBridge(QObject* parent)
    : QObject(parent),
    config(makeDefaultSolverConfig()),
    solver(config)
{
}

QVariantMap SolverBridge::solve(
    int start,
    int target,
    const QVariantList& finalMoves
    ) {
    QVariantMap response;
    QVariantList pathList;

    try {
        InputData input;

        input.setStart(start, config);
        input.setTarget(target, config);

        std::vector<int> moves;

        for (const QVariant& value : finalMoves) {
            bool ok = false;
            int move = value.toInt(&ok);

            if (!ok) {
                response["found"] = false;
                response["message"] = "Invalid final move value.";
                response["adjustedTarget"] = target;
                response["steps"] = 0;
                response["stepsCount"] = 0;
                response["path"] = pathList;
                return response;
            }

            moves.push_back(move);
        }

        input.setFinalMovesExecutionOrder(moves, config);

        SolveResult result = solver.solve(input);

        for (int move : result.path) {
            pathList.append(move);
        }

        const int steps = result.stepsCount();

        response["found"] = result.found;
        response["message"] = QString::fromStdString(result.message);
        response["adjustedTarget"] = result.adjustedTarget;

        // "steps" — для QML.
        response["steps"] = steps;

        // "stepsCount" — залишаємо для сумісності/дебагу.
        response["stepsCount"] = steps;

        response["path"] = pathList;
    }
    catch (const std::exception& exception) {
        response["found"] = false;
        response["message"] = QString::fromUtf8(exception.what());
        response["adjustedTarget"] = -1;
        response["steps"] = 0;
        response["stepsCount"] = 0;
        response["path"] = pathList;
    }

    return response;
}
