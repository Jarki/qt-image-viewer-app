#include "MyImageModel.h"

#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <iostream>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;

    MyImageModel model;
    engine.rootContext()->setContextProperty("myModel", QVariant::fromValue(&model));

    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

//    std::cout << engine.rootObjects().size() << std::endl;
    QObject* item = engine.rootObjects().first();
    QObject::connect(item, SIGNAL(fileChangedSignal(QString)), &model, SLOT(changeData(QString)));

    return app.exec();
}
