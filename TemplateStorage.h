#pragma once

#include "TemplateData.h"

#include <QString>
#include <QVector>

class TemplateStorage {
public:
    TemplateStorage();

    QVector<TemplateData> loadTemplates() const;
    bool saveTemplates(const QVector<TemplateData>& templates) const;

    bool saveOrReplaceTemplate(const TemplateData& data);
    bool deleteTemplateById(const QString& id);

    QString filePath() const;

private:
    QString templatesFilePath;

    static TemplateData templateFromJsonObject(const class QJsonObject& object);
    static QJsonObject templateToJsonObject(const TemplateData& data);
};
