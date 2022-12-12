#ifndef QARDUINOVELO_H
#define QARDUINOVELO_H

#include <QObject>
#include <QSerialPort>
#include <QSerialPortInfo>

struct SArduinoInfo
{
    Q_GADGET

    Q_PROPERTY(int turnPerMinute MEMBER mTurnPerMinute)
    Q_PROPERTY(int numTurns MEMBER mNumTurns)
    Q_PROPERTY(int heartBeatPerMinute MEMBER mHeartBeatPerMinute)

public:
    int mTurnPerMinute = 0;
    int mNumTurns = 0;
    int mHeartBeatPerMinute = 0;

    bool operator==(const SArduinoInfo& rhs) const { return mTurnPerMinute == rhs.mTurnPerMinute && mNumTurns == rhs.mNumTurns && mHeartBeatPerMinute == rhs.mHeartBeatPerMinute; }
    bool operator!=(const SArduinoInfo& rhs) const { return !(*this == rhs); }
};
Q_DECLARE_METATYPE(SArduinoInfo)

class QArduinoVelo : public QObject
{
    Q_OBJECT

public:
   SArduinoInfo mArduinoInfo;
   Q_PROPERTY(SArduinoInfo arduinoInfo MEMBER mArduinoInfo NOTIFY ArduinoInfoChanged)

protected:
   QSerialPort* SerialPort = nullptr;
   bool bConnected = false;
   QByteArray ReceivedData;

public:
    explicit QArduinoVelo(QObject *parent = nullptr);

   Q_INVOKABLE void tryConnect();

signals:
    void ArduinoInfoChanged();

public slots:
    void readSerial();

};

#endif // QARDUINOVELO_H
