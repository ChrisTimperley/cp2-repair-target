import flask


app: flask.Flask = flask.Flask(__name__)


@app.route('/perturbations', methods=['GET'])
def list_perturbations():
    jsn = []
    return flask.jsonify(jsn)


@app.route('/status', methods=['GET'])
def observe_status():
    jsn = []
    return flask.jsonify(jsn)


@app.route('/adapt', methods=['POST'])
def trigger_adaptation():
    jsn = []
    return flask.jsonify(jsn)


def run(port: int = 8000) -> None:
    app.run(port=port)


def main() -> None:
    run()
