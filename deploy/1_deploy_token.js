const func = async function (hre) {
    const { deployments, getNamedAccounts } = hre;
    const { deploy } = deployments;
  
    const { deployer } = await getNamedAccounts();
  
    await deploy('CubeToken', {
      from: deployer,
      args: [],
      log: true,
    });
  };
  module.exports = func;
  module.exports.tags = ['CubeToken'];