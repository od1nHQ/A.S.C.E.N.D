#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QCoreApplication>

#include "SolverBridge.h"

#include <QIcon>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    app.setWindowIcon(QIcon(":/qt/qml/ASCEND_GUI/assets/ui/app_icon.ico"));

    QQmlApplicationEngine engine;

    SolverBridge solverBridge;
    engine.rootContext()->setContextProperty("solverBridge", &solverBridge);

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
