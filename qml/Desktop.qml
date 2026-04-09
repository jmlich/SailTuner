/* Copyright 2016 (C) Louis-Joseph Fournier 
 * louisjoseph.fournier@gmail.com
 *
 * This file is part of SailTuner.
 *
 * SailTuner is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * SailTuner is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 */


import QtQuick 2.7
import Lomiri.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

//import QtQuick 2.0
//import QtQuick.Controls 1.0
//import QtQuick.Layouts 1.0
import LJTuner 1.0
import LJUtils 1.0

import "."

Item {
	id: root
	width: 600
	height: 500

	Tuner {
		id: tuner
		running: false
		temperament_idx: Config.temperament_idx
		la: Config.la
	}

	ObjectSaver {
		id: saver
		filename: "config.dat"
		object: Config
	}

	DesktopTheme {
		id: theme
	}

	Image {
		anchors.fill: parent
		source: "../images/bg_portrait.png"

		TunerScreen {
			anchors.fill: parent
			theme: theme
			tuner: tuner
			onToggleRun: tuner.running ^= true
		}

		MouseArea {
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.right: parent.right
			height: parent.height / 8

			onDoubleClicked: {
				var win = player.createObject(player, {theme: theme, tuner: tuner})
				win.show()
			}
		}
	}

	// player
	Component {
		id: player


MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'sailtuner.com.github.jmlich.sailtuner'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('SailTuner')
        }

        ColumnLayout {
            spacing: units.gu(2)
            anchors {
                margins: units.gu(2)
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            Item {
                Layout.fillHeight: true
            }

            Label {
                id: label
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press the button below and check the logs!')
            }

            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press here!')
                onClicked: Example.speak()
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }
}

/*
		ApplicationWindow {
			id: player_app

			width: 600
			height: 500
			property QtObject tuner
			property QtObject theme

			Image {
				source: "../images/bg_portrait.png"
				anchors.fill: parent
			}
			PlayerScreen {
				tuner: player_app.tuner
				theme: player_app.theme

				anchors.fill: parent
				onTogglePlay: tuner.playing ^= true
			}
		}
*/
	}
}
