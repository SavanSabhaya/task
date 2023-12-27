import 'dart:io';
import 'dart:math';

import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:task/api_service/api_constant.dart';

class MyMqttClient {
  MqttServerClient client = MqttServerClient.withPort(MqttConstant.baseMqttUrl, 'mqtt-clientsssss', MqttConstant.baseMqttPort);

  ///Connect With MQTT
  Future<int> connect() async {

    client.setProtocolV311();
    client.secure = true;
    client.autoReconnect = true;
    client.keepAlivePeriod = 60;
    client.connectTimeoutPeriod = 2000;
    client.logging(on: false);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.onSubscribed = onSubscribed;
    client.pongCallback = pong;

    try {
      await client.connect();
      return 1;
    } on NoConnectionException catch (e) {
      print('MQTTClient::Client exception - $e');
      client.disconnect();
      return 0;
    } on SocketException catch (e) {
      print('MQTTClient::Socket exception - $e');
      client.disconnect();
      return 0;
    } catch (e) {
      print('exception - $e');
      return 0;
    }
//    await MqttUtilities.asyncSleep(60);
  }

  ///Disconnect MQTT
  void disconnect() {
    client.disconnect();
  }

  ///Subscribe Topic wiche we need to send or receive
  void subscribe(String topic) {
    client.subscribe(topic, MqttQos.atLeastOnce);
  }

  ///Un Subscribe Topic wiche we need to send or receive
  void unSubscribe(String topic) {
    client.unsubscribe(topic);
  }

  void onConnected() {
    print('MQTTClient::Connected');
  }

  void onDisconnected() {
    print('MQTTClient::Disconnected');
  }

  void onSubscribed(String topic) {
    print('MQTTClient::Subscribed to topic: $topic');
  }

  void pong() {
    print('MQTTClient::Ping response received');
  }

  ///Send Message
  void publishMessage(String topic, String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    client.publishMessage(topic, MqttQos.exactlyOnce, builder.payload!);
  }

  ///Receive Message
  Stream<List<MqttReceivedMessage<MqttMessage>>>? getMessagesStream() {
    return client.updates;
  }
}
