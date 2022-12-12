#include "QArduinoVelo.h"

#include <QDebug>
#include <QJsonDocument>
#include <QJsonObject>

QArduinoVelo::QArduinoVelo(QObject *parent) : QObject{parent}
{

}

void QArduinoVelo::tryConnect()
{ 
    if (!SerialPort)
    {
        SerialPort = new QSerialPort(this);
    }

    if (SerialPort->isOpen())
        return;

    bool arduino_available = false;
    QString arduino_portName;

    qDebug() << "Number of ports" << QSerialPortInfo::availablePorts().length() << "\n";
    foreach(const QSerialPortInfo &serialPortInfo, QSerialPortInfo::availablePorts())
    {
      qDebug() << "Port name" << serialPortInfo.portName();
      qDebug() << "Description" << serialPortInfo.description();
      qDebug() << "Has Vendor Id?" << serialPortInfo.hasVendorIdentifier();
      qDebug() << "Vendor Id" << serialPortInfo.vendorIdentifier();
      qDebug() << "Has Product Id?" << serialPortInfo.hasProductIdentifier();
      qDebug() << "Product Id" << serialPortInfo.productIdentifier() << "\n";

      if (serialPortInfo.vendorIdentifier() == 9025)
      {
          arduino_available = true;
          arduino_portName = serialPortInfo.portName();
      }
    }

    if (arduino_available)
    {
        SerialPort->setPortName(arduino_portName);
        SerialPort->setBaudRate(QSerialPort::Baud9600);
        SerialPort->setDataBits(QSerialPort::Data8);
        SerialPort->setParity(QSerialPort::NoParity);
        SerialPort->setStopBits(QSerialPort::OneStop);
        SerialPort->setFlowControl(QSerialPort::NoFlowControl);
        SerialPort->open(QIODevice::ReadWrite);
        if (!SerialPort->isOpen())
        {
            qDebug() << "Arduino Not Opening";
        }
        else
        {
            SerialPort->flush();
            QObject::connect(SerialPort, SIGNAL(readyRead()), this, SLOT(readSerial()));
            SerialPort->write("{'status': 'ready'}");
        }
    } else {
        qDebug() << "Couldn't find correct arduino port.\n";
    }
}

bool QArduinoVelo::isConnected()
{
    return SerialPort && SerialPort->isOpen();
}

void QArduinoVelo::readSerial()
{
    ReceivedData += SerialPort->readAll();
    SerialPort->flush();
    qDebug() << "Received : " << ReceivedData;
    const qsizetype indexOfReturn = ReceivedData.indexOf('\r');
    if (indexOfReturn >= 0)
    {
        QString Line = ReceivedData.left(indexOfReturn);
        Line.replace('\n', "");
        qDebug() << Line;
        ReceivedData = ReceivedData.mid(indexOfReturn + 2);

        bool bDirty = false;
        QJsonDocument JsonDoc = QJsonDocument::fromJson(Line.toUtf8());
        QJsonObject JsonObject = JsonDoc.object();
        QJsonValue TpmValue = JsonObject.value("tpm");
        if (TpmValue.isDouble())
        {
            mArduinoInfo.mTurnPerMinute = std::round(TpmValue.toDouble());
            bDirty = true;
        }
        QJsonValue NumTurnsValue = JsonObject.value("numTurns");
        if (NumTurnsValue.isDouble())
        {
            mArduinoInfo.mNumTurns = std::round(NumTurnsValue.toDouble());
            bDirty = true;
        }
        QJsonValue hbpmValue = JsonObject.value("hbpm");
        if (hbpmValue.isDouble())
        {
            mArduinoInfo.mHeartBeatPerMinute = std::round(hbpmValue.toDouble());
            bDirty = true;
        }
        if (bDirty)
        {
            emit ArduinoInfoChanged();
            qDebug() << "emit " << mArduinoInfo.mTurnPerMinute;
        }
    }
}
