import QtQuick 2.5
import QtGraphicalEffects 1.0

Rectangle {
    id: root
    width: 200
    height: 100
    color: "black"
    
    
    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true
            preOpacityAnimation.from = 0;
            preOpacityAnimation.to = 1;
            preOpacityAnimation.running = true;
        }
        if (stage == 4) {
            preOpacityAnimation.from = 1;
            preOpacityAnimation.to = 0;
            preOpacityAnimation.running = true;
            pausa.start();
        }
    }
    
    Image {
        id: dragon
        opacity: 1
        source: "images/BadDragon.svg"
        fillMode: Image.PreserveAspectFit
        height: parent.height * 0.5
        width: parent.height * 0.5
        anchors.horizontalCenter: parent.horizontalCenter
        y: parent.height * 0.2
    }
    
    Image {
        id: topRect
        anchors.horizontalCenter: parent.horizontalCenter
        y: root.height
        source: "images/rectangle.svg"
        Rectangle {
            y: 232
            radius: 0
            anchors.horizontalCenterOffset: 0
            color: "#600000"
            anchors {
                bottom: parent.bottom
                bottomMargin: 50
                horizontalCenter: parent.horizontalCenter
            }
            height: 2
            width: height*200
            Rectangle {
                id: topRectRectangle
                radius: 1
                anchors {
                    left: parent.left
                    top: parent.top
                    bottom: parent.bottom
                }
                width: (parent.width / 6) * (stage - 0.00)
                color: "#ff0000"
                Behavior on width {
                    PropertyAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }
    
    SequentialAnimation {
        id: introAnimation
        running: false

        ParallelAnimation {
            PropertyAnimation {
                property: "y"
                target: topRect
                to: ((root.height / 3) * 2) - 100
                duration: 1500
                easing.type: Easing.InOutBack
                easing.overshoot: 1.0
            }
            
        }
    }
        
    Timer {
        id: pausa
        interval: 1500; running: false; repeat: false;
        onTriggered: root.viewLoadingText();
    }
}
