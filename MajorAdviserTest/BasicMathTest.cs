using MajorAdviser.Class;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace MajorAdviserTest
{
    [TestClass]
    public class BasicMathTest
    {
        [TestMethod]
        public void AddTwoNumberTest()
        {
            //Arrange
            //System Under Test or sut
            BasicMath sut = new BasicMath();
            //Act
            int num = sut.AddTwoNumber(2, 5);
            //Assert
            Assert.AreEqual(num,7);
        }
    }
}
