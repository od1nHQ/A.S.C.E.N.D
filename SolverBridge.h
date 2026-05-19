#pragma once

#include <QObject>
#include <QVariantList>
#include <QVariantMap>

#include "core/config.h"
#include "core/input.h"
#include "core/solver.h"

class SolverBridge : public QObject {
    Q_OBJECT

public:
    explicit SolverBridge(QObject* parent = nullptr);

    Q_INVOKABLE QVariantMap solve(
        int start,
        int target,
        const QVariantList& finalMoves
        );

private:
    SolverConfig config;
    AscendSolver solver;
};
