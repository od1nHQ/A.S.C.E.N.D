#include "TemplateBridge.h"
#include <QDir>
#include <QFileInfo>
#include <QStringList>

TemplateBridge::TemplateBridge(QObject* parent)
    : QObject(parent)
{
}

QVariantList TemplateBridge::loadTemplates() {
    QVariantList result;

    const QVector<TemplateData> templates = storage.loadTemplates();

    for (const TemplateData& data : templates) {
        result.append(templateToVariantMap(data));
    }

    return result;
}

QVariantMap TemplateBridge::saveTemplate(
    const QString& id,
    const QString& name,
    const QString& material,
    const QString& category,
    const QString& icon,
    int target,
    const QVariantList& finalMoves
    ) {
    QVariantMap response;

    TemplateData data;
    data.id = id.trimmed();
    data.name = name.trimmed();
    data.material = material.trimmed();
    data.category = category.trimmed();
    data.icon = icon.trimmed();
    data.target = target;

    for (const QVariant& value : finalMoves) {
        bool ok = false;
        const int move = value.toInt(&ok);

        if (ok) {
            data.finalMoves.push_back(move);
        }
    }

    if (data.id.isEmpty()) {
        response["ok"] = false;
        response["message"] = "Template id is empty.";
        return response;
    }

    if (data.name.isEmpty()) {
        response["ok"] = false;
        response["message"] = "Template name is empty.";
        return response;
    }

    if (data.finalMoves.isEmpty() || data.finalMoves.size() > 3) {
        response["ok"] = false;
        response["message"] = "Final moves count must be 1-3.";
        return response;
    }

    const bool saved = storage.saveOrReplaceTemplate(data);

    response["ok"] = saved;
    response["message"] = saved ? "Template saved." : "Failed to save template.";
    response["template"] = templateToVariantMap(data);

    return response;
}

bool TemplateBridge::deleteTemplate(const QString& id) {
    return storage.deleteTemplateById(id);
}

QString TemplateBridge::templatesFilePath() const {
    return storage.filePath();
}

QVariantMap TemplateBridge::templateToVariantMap(const TemplateData& data) {
    QVariantMap map;
    QVariantList moves;

    for (int move : data.finalMoves) {
        moves.append(move);
    }

    map["id"] = data.id;
    map["name"] = data.name;
    map["material"] = data.material;
    map["category"] = data.category;
    map["icon"] = data.icon;
    map["target"] = data.target;
    map["finalMoves"] = moves;

    return map;
}

static QString displayNameFromToken(QString token) {
    token = token.replace("_", " ");

    QStringList parts = token.split(" ", Qt::SkipEmptyParts);

    for (QString& part : parts) {
        if (!part.isEmpty()) {
            part[0] = part[0].toUpper();
        }
    }

    return parts.join(" ");
}

QVariantList TemplateBridge::loadAvailableItems() {
    QVariantList result;

    const QString resourceRootPath = ":/qt/qml/ASCEND_GUI/assets/templates/items";
    QDir rootDir(resourceRootPath);

    if (!rootDir.exists()) {
        return result;
    }

    const QStringList categoryDirs = rootDir.entryList(
        QDir::Dirs | QDir::NoDotAndDotDot,
        QDir::Name
        );

    for (const QString& category : categoryDirs) {
        QDir categoryDir(rootDir.filePath(category));

        const QFileInfoList imageFiles = categoryDir.entryInfoList(
            QStringList() << "*.png",
            QDir::Files,
            QDir::Name
            );

        for (const QFileInfo& fileInfo : imageFiles) {
            const QString material = fileInfo.completeBaseName();
            const QString fileName = fileInfo.fileName();

            QVariantMap item;

            item["id"] = category + "_" + material;
            item["name"] = displayNameFromToken(category);
            item["material"] = material;
            item["category"] = category;
            item["icon"] = "assets/templates/items/"
                           + category
                           + "/"
                           + fileName;

            result.append(item);
        }
    }

    return result;
}
