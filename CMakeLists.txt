cmake_minimum_required(VERSION 3.4)
project(Swen)

set(SOURCE_FILES
        Sources/Swen/main.swift
        Sources/Swen/Texture.swift
        Sources/Swen/Font.swift
        Sources/Swen/Media/FileFormats/AudioFile.swift
        Sources/Swen/Media/FileFormats/FontFile.swift
        Sources/Swen/Media/FileFormats/ImageFile.swift
        Sources/Swen/Media/Loaders/AudioLoader.swift
        Sources/Swen/Media/Loaders/FontLoader.swift
        Sources/Swen/Media/Loaders/ImageLoader.swift
        Sources/Swen/Media/AssetLoader.swift
        Sources/Swen/Media/ContentPipeline.swift
        Sources/Swen/Events/AudioDeviceEvent.swift
        Sources/Swen/Events/BaseEvent.swift
        Sources/Swen/Events/CommonEvent.swift
        Sources/Swen/Events/ControllerAxisEvent.swift
        Sources/Swen/Events/ControllerButtonEvent.swift
        Sources/Swen/Events/ControllerDeviceEvent.swift
        Sources/Swen/Events/DropEvent.swift
        Sources/Swen/Events/JoyAxisEvent.swift
        Sources/Swen/Events/JoyBallEvent.swift
        Sources/Swen/Events/JoyButtonEvent.swift
        Sources/Swen/Events/JoyDeviceEvent.swift
        Sources/Swen/Events/JoyHatEvent.swift
        Sources/Swen/Event.swift
        Sources/Swen/Events/KeyboardEvent.swift
        Sources/Swen/Events/MouseButtonEvent.swift
        Sources/Swen/Events/MouseMotionEvent.swift
        Sources/Swen/Events/MouseWheelEvent.swift
        Sources/Swen/Events/QuitEvent.swift
        Sources/Swen/Events/SysWMEvent.swift
        Sources/Swen/Events/TextEditingEvent.swift
        Sources/Swen/Events/TextInputEvent.swift
        Sources/Swen/Events/UserEvent.swift
        Sources/Swen/Events/WindowEvent.swift
        Sources/Swen/Extensions/SDLExtension.swift
        Sources/Swen/Extensions/SDLExtensionCore.swift
        Sources/Swen/Extensions/SDLExtensionImage.swift
        Sources/Swen/Extensions/SDLExtensionLoader.swift
        Sources/Swen/Extensions/SDLExtensionMixer.swift
        Sources/Swen/Extensions/SDLExtensionNet.swift
        Sources/Swen/Extensions/SDLExtensionTTF.swift
        Sources/Swen/Game.swift
        Sources/Swen/Network/Socket.swift
        Sources/Swen/Network/TCPSocket.swift
        Sources/Swen/Network/UDPSocket.swift
        Sources/Swen/Renderer.swift
        Sources/Swen/SDL/SDL.swift
        Sources/Swen/SDL/SDLError.swift
        Sources/Swen/Surface.swift
        Sources/Swen/Timer.swift
        Sources/Swen/Window.swift
        Sources/Swen/Util/Extensions/ArrayExtensions.swift
        Sources/Swen/Util/Extensions/OptionalExtensions.swift
        Sources/Swen/Util/Arithmetic.swift
        Sources/Swen/Util/Colour.swift
        Sources/Swen/Util/IPAddress.swift
        Sources/Swen/Util/Point.swift
        Sources/Swen/Util/Rect.swift
        Sources/Swen/Util/SDLConvertHelper.swift
        Sources/Swen/Util/Size.swift
        Sources/Swen/Util/Vector.swift
        Package.swift)

#set(PACKAGES
#    Packages/.git-1.0.0/Package.swift)

add_custom_target(
        COMMAND /usr/bin/swift build
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        SOURCES ${SOURCE_FILES})
