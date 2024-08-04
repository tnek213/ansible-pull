from pprint import pprint
from ansible.plugins.action import ActionBase
from ansible.errors import AnsibleActionFail

from ansible_collections.local.distadapt.plugins.modules.yolo import yolo

class ActionModule(ActionBase):

	_requires_connection = True

	print(yolo())

	needed_facts = ['distribution', 'distribution_version', 'distribution_major_version', 'os_family']

	def _get_missing_facts(self, facts):
		return {missing_fact for missing_fact in self.needed_facts if missing_fact not in facts}

	def run(self, tmp=None, task_vars=None):
		super().run(tmp, task_vars)

		del tmp  # tmp is deprecated

		if task_vars is None:
			task_vars = dict()

		# # get play directory
		# play_dir = self._loader.get_basedir()

		facts = task_vars.get('ansible_facts', {})

		missing_facts = self._get_missing_facts(facts)

		if len(missing_facts) > 0:
			# TODO: Check what logs at different verbosity levels in ansible core and follow convention
			if self._display.verbosity >= 2:
				self._display.warning(f'Will gather missing OS facts: {", ".join(missing_facts)}')

			subset_query = f'!all,!min,{",".join(missing_facts)}'
			setup_result = self._execute_module(module_name='setup', module_args={'gather_subset': subset_query }, task_vars=task_vars)

			pprint(setup_result)

			if setup_result.get('failed', False):
				raise AnsibleActionFail('Failed to gather facts')

			facts = setup_result.get('ansible_facts', {})
			facts = {k.replace('ansible_', ''): v for k, v in facts.items()}

			missing_facts = self._get_missing_facts(facts)

			if len(missing_facts) > 0:
				raise AnsibleActionFail(f'Failed to gather facts: {", ".join(missing_facts)}')


    #  - "{{['os', facts['distribution'], facts['distribution_version'] | replace('.', '_')]}}"
    #   - "{{['os', facts['distribution'], facts['distribution_major_version']]}}"
    #   - "{{['os', facts['distribution']]}}"
    #   - "{{['os_family', facts['os_family']]}}"


		# print(f'sd: {play_dir})')

		results = { "ansible_facts": { "x": 123 } }

		return results

