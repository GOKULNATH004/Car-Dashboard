#ifndef UISETTINGS_H
#define UISETTINGS_H

#include <QObject>
#include <QString>
#include <QTranslator>

class UiSettings : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString emptyString READ getEmptyString NOTIFY languageChanged)

public:
    explicit UiSettings(QObject *parent = nullptr);
    void setTranslator(QTranslator *pTranslator);
    QString getEmptyString() { return ""; }

signals:
    void languageChanged();

public slots:
    void languageSelectedSlot(QString language);

private:
    QTranslator*    m_pTranslator;
    QString         m_Language;
};

#endif
