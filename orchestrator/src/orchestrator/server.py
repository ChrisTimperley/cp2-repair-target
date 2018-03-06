import flask
import hulk
import argparse


app: flask.Flask = flask.Flask(__name__)
hulk_client: hulk.Client = None


@app.route('/perturbations', methods=['GET'])
def list_perturbations():
    """
    Computes a list of all possible perturbations to the source code of the
    system under repair. Optionally, a set of criteria may be provided to
    restrict the set of perturbations.
    """
    jsn = []

    # determine the file
    fn = TODO

    mutations = hulk_client.mutations(fn)

    return flask.jsonify(jsn)


@app.route('/status', methods=['GET'])
def observe_status():
    jsn = []
    return flask.jsonify(jsn)


@app.route('/adapt', methods=['POST'])
def trigger_adaptation():
    jsn = []
    return flask.jsonify(jsn)


def run(hulk_url: str,
        port: int = 8000
        ) -> None:
    """
    Launches an orchestrator server, and blocks until the server is
    terminated.

    Parameters:
        hulk_url:   the base URL of the Hulk server.
        port:       the port that the orchestrator should run on.
    """
    global hulk_client
    assert 0 <= port <= 49151, "invalid port number"

    # TODO: wait for client
    hulk_client = hulk.Client(hulk_url)
    app.run(port=port)


def main() -> None:
    desc = 'MARS CP2 Orchestrator -- Welcome to Mars.'
    parser = argparse.ArgumentParser(description=desc)
    parser.add_argument('--hulk',
                        type=str,
                        required=True,
                        help='the base URL of the Hulk server')
    parser.add_argument('--port',
                        type=int,
                        required=True,
                        help='the port that should be used by this server.')
    # TODO: require --bugzoo argument
    # TODO: require --darjeeling argument

    args = parser.parse_args()
    run(hulk_url=args.hulk,
        port=args.port)
