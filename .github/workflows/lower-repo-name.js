const core = require('@actions/core');
const github = require('@actions/github');

async function run() {
  try {
    const repoName = github.context.actor.toLowerCase();
    core.exportVariable('LOWER_REPO_NAME', repoName);
  } catch (error) {
    core.setFailed(error.message);
  }
}

run();
