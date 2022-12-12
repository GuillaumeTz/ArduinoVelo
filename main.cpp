#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include "QArduinoVelo.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QArduinoVelo* ArduinoVelo = new QArduinoVelo(&app);

    qmlRegisterModule("com.ArduiVelo.appArduiVelo", 1, 0);
    qmlRegisterSingletonInstance<QArduinoVelo>("com.ArduiVelo.appArduiVelo", 1, 0, "ArduinoVelo", ArduinoVelo);

    QQmlApplicationEngine engine;
    const QUrl url(u"qrc:/ArduiVelo/main.qml"_qs);
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);   
    engine.load(url);

    return app.exec();
}
