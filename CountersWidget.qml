import QtQuick

import com.ArduiVelo.appArduiVelo

CountersWidgetForm
{
    property int startTurn: 0;
    property bool bStarted: false;
    property var startTime;

    Component.onCompleted:
    {
        ArduinoVelo.onArduinoInfoChanged.connect(updateValues);
    }

    startButton.onClicked:
    {
        if (bStarted)
        {
            bStarted = false;
            startButton.text = "Start";
        }
        else
        {
            startTime = Date.now();
            startTurn = ArduinoVelo.arduinoInfo.numTurns;
            bStarted = true;
            startButton.text = "Stop";
        }
    }

    Timer
    {
        interval: 1000
        repeat: true
        running: true

        onTriggered:
        {
            if (!bStarted)
                return;

            let ElapsedTime = new Date(Date.now() - startTime);
            console.log(ElapsedTime);
            timeText.text = ElapsedTime.getMinutes() + "m " + ElapsedTime.getSeconds() + "s";
        }
    }

    function updateValues()
    {
        tpmText.text = ArduinoVelo.arduinoInfo.turnPerMinute;
        turnsText.text = ArduinoVelo.arduinoInfo.numTurns - startTurn;
        hbpmText.text = ArduinoVelo.arduinoInfo.heartBeatPerMinute;
    }
}
