#pragma once

#include <QString>
#include <QVector>

struct TemplateData {
    QString id;
    QString name;
    QString material;
    QString category;
    QString icon;

    int target = 0;
    QVector<int> finalMoves;
};
