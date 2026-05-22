#pragma once

#include "TemplateStorage.h"

#include <QObject>
#include <QVariantList>
#include <QVariantMap>

class TemplateBridge : public QObject {
    Q_OBJECT

public:
    explicit TemplateBridge(QObject* parent = nullptr);

    Q_INVOKABLE QVariantList loadTemplates();

    Q_INVOKABLE QVariantList loadAvailableItems();

    Q_INVOKABLE QVariantMap saveTemplate(
        const QString& id,
        const QString& name,
        const QString& material,
        const QString& category,
        const QString& icon,
        int target,
        const QVariantList& finalMoves
        );

    Q_INVOKABLE bool deleteTemplate(const QString& id);
    Q_INVOKABLE QString templatesFilePath() const;

private:
    TemplateStorage storage;

    static QVariantMap templateToVariantMap(const TemplateData& data);
};
