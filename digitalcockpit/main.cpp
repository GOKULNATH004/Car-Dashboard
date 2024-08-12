#include <QGuiApplication>

#include <QQmlApplicationEngine>

#include<QQmlContext>

#include<C:\Users\hari\Desktop\digitalcockpit\controller/hvachandler.h>

#include<C:\Users\hari\Desktop\digitalcockpit\controller/system.h>

int main(int argc, char *argv[])

{

#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)

    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

#endif



    QGuiApplication app(argc, argv);

    System m_systemHandler;

    HVACHandler m_driverHVACHandler;

    HVACHandler m_passenderHVACHandler;

    QQmlApplicationEngine engine;

    QQmlContext *context = engine.rootContext();

    context->setContextProperty("systemHandler",&m_systemHandler);
    context->setContextProperty("driverHVAC",&m_driverHVACHandler);
    context->setContextProperty("passengerHVAC",&m_passenderHVACHandler);

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,

                     &app, [url](QObject *obj, const QUrl &objUrl) {

        if (!obj && url == objUrl)

            QCoreApplication::exit(-1);

    }, Qt::QueuedConnection);

    engine.load(url);

    return app.exec();

}


