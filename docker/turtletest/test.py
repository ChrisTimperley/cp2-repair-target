#!/usr/bin/env python
import sys

from runner import Mission


if __name__ == '__main__':
    if len(sys.argv) != 2:
        print("USAGE: ./test.py [test-id]")
        exit(1)

    cfg = "/home/mars/catkin_ws/src/turtlebot_simulator/turtlebot_gazebo/launch/robotest.launch"
    params = {}

    test_id = sys.argv[1]

    tests = {
        'one': Mission(60, (3.0, 3.0, 0.0), params)
    }

    if test_id not in tests:
        print("ERROR: test not found: {}".format(test_id))
        exit(1)

    test = tests[test_id]
    outcome = test.execute()
    print("OUTCOME: {}".format(outcome))

    if isinstance(outcome, runner.GoalReachedOutcome):
        print("SUCCESS")
        exit(0)

    else:
        print("FAILURE")
        exit(1)
