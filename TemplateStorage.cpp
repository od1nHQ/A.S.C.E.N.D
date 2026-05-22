#include "TemplateStorage.h"

#include <QCoreApplication>
#include <QDir>
#include <QFile>
#include <QJsonArray>
#include <QJsonDocument>
#include <QJsonObject>
#include <QStandardPaths>

TemplateStorage::TemplateStorage() {
    QString dataPath = QCoreApplication::applicationDirPath() + "/data";

    QDir dir(dataPath);

    if (!dir.exists()) {
        dir.mkpath(".");
    }

    templatesFilePath = dir.filePath("templates.json");
}

QString TemplateStorage::filePath() const {
    return templatesFilePath;
}

QVector<TemplateData> TemplateStorage::loadTemplates() const {
    QVector<TemplateData> result;

    QFile file(templatesFilePath);

    if (!file.exists()) {
        return result;
    }

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        return result;
    }

    const QByteArray rawData = file.readAll();
    file.close();

    QJsonParseError parseError;
    const QJsonDocument document = QJsonDocument::fromJson(rawData, &parseError);

    if (parseError.error != QJsonParseError::NoError || !document.isObject()) {
        return result;
    }

    const QJsonObject rootObject = document.object();
    const QJsonArray templatesArray = rootObject.value("templates").toArray();

    for (const QJsonValue& value : templatesArray) {
        if (!value.isObject()) {
            continue;
        }

        result.push_back(templateFromJsonObject(value.toObject()));
    }

    return result;
}

bool TemplateStorage::saveTemplates(const QVector<TemplateData>& templates) const {
    QJsonObject rootObject;
    rootObject["version"] = 1;

    QJsonArray templatesArray;

    for (const TemplateData& data : templates) {
        templatesArray.append(templateToJsonObject(data));
    }

    rootObject["templates"] = templatesArray;

    QFile file(templatesFilePath);

    const QFileInfo fileInfo(templatesFilePath);
    QDir dir = fileInfo.absoluteDir();

    if (!dir.exists()) {
        dir.mkpath(".");
    }

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text | QIODevice::Truncate)) {
        return false;
    }

    const QJsonDocument document(rootObject);
    file.write(document.toJson(QJsonDocument::Indented));
    file.close();

    return true;
}

bool TemplateStorage::saveOrReplaceTemplate(const TemplateData& data) {
    if (data.id.trimmed().isEmpty()) {
        return false;
    }

    QVector<TemplateData> templates = loadTemplates();

    bool replaced = false;

    for (TemplateData& existing : templates) {
        if (existing.id == data.id) {
            existing = data;
            replaced = true;
            break;
        }
    }

    if (!replaced) {
        templates.push_back(data);
    }

    return saveTemplates(templates);
}

bool TemplateStorage::deleteTemplateById(const QString& id) {
    QVector<TemplateData> templates = loadTemplates();
    QVector<TemplateData> filtered;

    bool removed = false;

    for (const TemplateData& data : templates) {
        if (data.id == id) {
            removed = true;
            continue;
        }

        filtered.push_back(data);
    }

    if (!removed) {
        return false;
    }

    return saveTemplates(filtered);
}

TemplateData TemplateStorage::templateFromJsonObject(const QJsonObject& object) {
    TemplateData data;

    data.id = object.value("id").toString();
    data.name = object.value("name").toString();
    data.material = object.value("material").toString();
    data.category = object.value("category").toString();
    data.icon = object.value("icon").toString();
    data.target = object.value("target").toInt(0);

    const QJsonArray movesArray = object.value("finalMoves").toArray();

    for (const QJsonValue& value : movesArray) {
        data.finalMoves.push_back(value.toInt());
    }

    return data;
}

QJsonObject TemplateStorage::templateToJsonObject(const TemplateData& data) {
    QJsonObject object;

    object["id"] = data.id;
    object["name"] = data.name;
    object["material"] = data.material;
    object["category"] = data.category;
    object["icon"] = data.icon;
    object["target"] = data.target;

    QJsonArray movesArray;

    for (int move : data.finalMoves) {
        movesArray.append(move);
    }

    object["finalMoves"] = movesArray;

    return object;
}
