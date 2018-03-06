import flask


app: flask.Flask = flask.Flask(__name__)


@app.route('/perturbations', methods=['GET'])
def list_perturbations():
    jsn = []
    return flask.jsonify(jsn)


def run(port: int = 8000) -> None:
    app.run(port=port)


def main() -> None:
    run()
