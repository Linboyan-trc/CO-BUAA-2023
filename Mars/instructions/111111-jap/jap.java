import mars.Globals;
import mars.ProcessingException;
import mars.ProgramStatement;
import mars.mips.hardware.AddressErrorException;
import mars.mips.hardware.RegisterFile;
import mars.mips.instructions.AdditionalInstruction;
import mars.mips.instructions.BasicInstruction;
import mars.mips.instructions.BasicInstructionFormat;
import mars.mips.instructions.BranchOperation;
import mars.mips.instructions.SimulationCode;


public class jap extends BranchOperation implements AdditionalInstruction {

    @Override
    public void simulate(ProgramStatement statement) throws ProcessingException {

        int[] operands = statement.getOperands();
        processJump(
            ((RegisterFile.getProgramCounter() & 0xF0000000)
                    | (operands[0] << 2)));

        try
        {
        Globals.memory.setWord(
            RegisterFile.getValue(29),
            RegisterFile.getProgramCounter());
        } 
            catch (AddressErrorException e)
        {
            throw new ProcessingException(statement, e);
        }

        RegisterFile.updateRegister(29,RegisterFile.getValue(29)-4);
    }

    @Override
    public String getExample() {
        return "jap";
    }

    @Override
    public String getDescription() {
        return "jap";
    }

    @Override
    public BasicInstructionFormat getInstructionFormat() {
        return BasicInstructionFormat.J_FORMAT;
    }

    @Override
    public String getOperationMask() {
        return "111111 ffffffffffffffffffffffffff";
    }
}
