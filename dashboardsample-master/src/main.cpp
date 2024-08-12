#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QTranslator>
#include <QDebug>
#include "fileio.h"
#include "uisettings.h"

QTranslator translator;

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    app.installTranslator(&translator);


    qmlRegisterType<FileIO, 1>("io.dtv.fileio", 1, 0, "FileIO");

    qmlRegisterType<UiSettings>("io.dtv.uisettings", 1, 0, "UiSettings");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QLatin1String("qrc:/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    UiSettings uisettings;
    uisettings.setTranslator(&translator);

    QObject *item = engine.rootObjects()[0];
    QObject::connect(item, SIGNAL(languageSelected(QString)),
                     &uisettings, SLOT(languageSelectedSlot(QString)));

    int ret = app.exec();

    QObject::disconnect(item, SIGNAL(languageSelected(QString)),
                        &uisettings, SLOT(languageSelectedSlot(QString)));

    return ret;
}
