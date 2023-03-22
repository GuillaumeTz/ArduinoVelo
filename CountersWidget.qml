import QtQuick
import QtQuick.Controls
import QtCharts

import com.ArduiVelo.appArduiVelo

CountersWidgetForm
{
    property int startTurn: 0;
    property bool bStarted: false;
    property var startTime;
    property int tpmIndex: 0;

    Component.onCompleted:
    {
        //ArduinoVelo.onArduinoInfoChanged.connect(updateValues);
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
            updateValues();

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

        valueAxisTPM_X.min = Math.max(0, tpmIndex - 40);
        valueAxisTPM_X.max = Math.max(60, tpmIndex + 20);
        // find max for last points
        let maxValue = Math.max(50, ArduinoVelo.arduinoInfo.turnPerMinute);
        let minValue = Math.min(50, ArduinoVelo.arduinoInfo.turnPerMinute);
        for (let Index = Math.max(tpmIndex - 10, 0); Index < tpmIndex; ++Index)
        {
            maxValue = Math.max(maxValue, splineTPMSeries.at(Index).y);
            minValue = Math.min(minValue, splineTPMSeries.at(Index).y);
        }
        valueAxisTPM_Y.min = (Math.ceil((minValue / 10) - 0.1) - 1) * 10;
        valueAxisTPM_Y.max = (Math.ceil((maxValue / 10) + 0.1) + 1) * 10;

        splineTPMSeries.append(tpmIndex++, ArduinoVelo.arduinoInfo.turnPerMinute);
        if (tpmIndex > 65)
        {
            splineTPMSeries.removePoints(0, 1);
        }
    }
}
