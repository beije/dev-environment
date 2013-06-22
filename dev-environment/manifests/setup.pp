#
# Dev environment main setup files
#

import "classes/*.pp"

class dev {

    stage {
        pre:    before => Stage[update];
        update: before => Stage[basics];
        basics: before => Stage[main];
    }

    class {
        update_sources: stage => update;
        update_hosts:   stage => update;
        update_repos:   stage => pre;

        apache:         stage => basics;
        mysql:          stage => basics;
        php:            stage => basics;
        link_webroot:   stage => basics;

        site_config: stage => main;
    }

}

include dev