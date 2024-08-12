#include "uisettings.h"
#include <QGuiApplication>
#include <QDebug>

UiSettings::UiSettings(QObject *parent) :
    QObject(parent),
    m_pTranslator(NULL)
{
}

void UiSettings::setTranslator(QTranslator *pTranslator)
{
    m_pTranslator = pTranslator;
}

void UiSettings::languageSelectedSlot(QString language)
{
    if (m_Language != language)
    {
        qDebug() << "UI Language selected: " << language;
        if (!m_pTranslator)
            qWarning() << "No Translator available!";
        else
        {
            if (qApp)
                qApp->removeTranslator(m_pTranslator);

            if (language != "en")
            {

                if (!m_pTranslator->load("dashboard_" + language, ":/"))
                    qWarning() << "Translator failed to load resource for language " << language;
                else
                {

                    m_Language = language;
                    emit languageChanged();
                }
            }
        }
    }
}
