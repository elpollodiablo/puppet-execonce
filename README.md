# puppet-once
Exec resource that does not execute the command when it was run successfully already.

example:

        once::exec {"/bin/echo foo":
        }

the state files live in /var/lib/puppet-execonce/ by default. Once they are deleted, the exec resource will be re-applied. once::exec takes all the arguments of exec, except "creates".

If you want to use a different state directory, do so by either configuring the class:

	class {"once":
		state_dir => "/tmp/puppet-execonce"
	}

or by individual argument to once::exec:

        once::exec {"/bin/echo foo":
		state_dir => "/tmp/puppet-execonce"
        }

The directory you use as state dir needs to be managed by puppet.
