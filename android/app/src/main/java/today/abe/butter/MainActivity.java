package today.abe.butter;

import android.content.Intent;
import android.os.Bundle;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.Set;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  MethodChannel mChan;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    mChan = new MethodChannel(getFlutterView(), "app.channel.shared.data");
    _logIntent("CREATE", getIntent());
  }

  String getSerializedIntentExtras(Intent intent) {
    JSONObject json = new JSONObject();
    Bundle extras = intent.getExtras();
    Set<String> keys = extras.keySet();
    for (String key : keys) {
      try {
        // json.put(key, bundle.get(key)); see edit below
        json.put(key, JSONObject.wrap(extras.get(key)));
      } catch(JSONException e) {
        //Handle exception here
      }
    }
    return json.toString();
  }

  void _logIntent(String event, Intent intent) {
    String[] data = new String[]{
            event,
            getIntent().getAction().toString(),
            getSerializedIntentExtras(intent),
            intent.getData() != null ? intent.getData().toString(): "No Data"
    };
    String output = "";

    for (int index = 0; index < data.length; index++) {
      output += data[index] + ":";
    }

    mChan.invokeMethod("log", output);
  }

  @Override
  protected void onNewIntent(Intent intent) {
    super.onNewIntent(intent);
    _logIntent("NEW", intent);
  }

  @Override
  protected void onResume() {
    super.onResume();
    _logIntent("RESUME", getIntent());
  }
}