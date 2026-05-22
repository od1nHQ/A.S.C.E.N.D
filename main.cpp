#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QCoreApplication>
#include <QIcon>

#include "SolverBridge.h"
#include "TemplateBridge.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setOrganizationName("");
    QCoreApplication::setApplicationName("A.S.C.E.N.D");

    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/qt/qml/ASCEND_GUI/assets/ui/app_icon.ico"));

    QQmlApplicationEngine engine;

    SolverBridge solverBridge;
    TemplateBridge templateBridge;

    engine.rootContext()->setContextProperty("solverBridge", &solverBridge);
    engine.rootContext()->setContextProperty("templateBridge", &templateBridge);

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() {
            QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection
        );

    engine.loadFromModule("ASCEND_GUI", "Main");

    return app.exec();
}

