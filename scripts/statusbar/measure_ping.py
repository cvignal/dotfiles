#!/usr/bin/env python3

"""
A module for Polybar which measures and prints the current
ping time periodically or upon receiving a SIGUSR1 signal.

Author: Benedikt Vollmerhaus <benedikt@vollmerhaus.org>
License: MIT
"""

import re
import signal
import subprocess
import threading
from typing import Pattern

HOST_TO_PING: str = '1.1.1.1'

PING_PATTERN: Pattern = re.compile(r'time=([0-9]+(\.[0-9]+)?) ms')


def update_output(_signum=None, _frame=None) -> None:
    """
    Print the current ping and schedule the next measurement.

    :return: None
    """
    if update_output.timer is not None:
        update_output.timer.cancel()

    print(f'{_measure_ping(HOST_TO_PING)} ms', flush=True)

    update_output.timer = threading.Timer(10, update_output)
    update_output.timer.start()


update_output.timer = None


def _measure_ping(host: str) -> str:
    """
    Measure and return the current ping time to a given host.

    :param host: A host to ping
    :return: The ping time or '-' if the host is unreachable
    """
    try:
        ping_output: bytes = subprocess.check_output(
            ['ping', host, '-c', '1'], stderr=subprocess.DEVNULL)
        return PING_PATTERN.search(ping_output.decode()).group(1)
    except subprocess.CalledProcessError:
        return '-'


if __name__ == '__main__':
    update_output()
    signal.signal(signal.SIGUSR1, update_output)

